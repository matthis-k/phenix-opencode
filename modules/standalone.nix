{ inputs, lib, ... }: {
  perSystem =
    { pkgs, system, ... }:
    let
      inherit (inputs) nix-wrapper-modules;
      codebase-memory-mcp = inputs.nixpkgs-unstable.legacyPackages.${system}.codebase-memory-mcp;

      mkMcpServer = name: pkgAttr: {
        type = "local";
        command = [ "${inputs.phenix-tools.packages.${system}."${pkgAttr}"}/bin/${name}" ];
        enabled = true;
      };

      promptsDir = ../prompts;
      commandsDir = ../commands;

      promptPath = name: builtins.toString promptsDir + "/${name}.md";

      readOnlyAgentPermissions = {
        read = "allow";
        glob = "allow";
        grep = "allow";
        list = "allow";
        edit = "deny";
        bash = {
          "*" = "deny";
          "git status*" = "allow";
          "git diff*" = "allow";
          "git log*" = "allow";
        };
        "codebase_memory_*" = "allow";
      };

      settings = {
        "$schema" = "https://opencode.ai/config.json";
        autoupdate = false;

        command = {
          flow = {
            description = "Run full Phenix plan -> architecture -> implementation -> verification workflow";
            agent = "workflow";
            template = builtins.readFile (commandsDir + "/flow.md");
          };
        };

        mcp = {
          tend-mcp = mkMcpServer "tend-mcp" "tend-mcp";
          stitch-mcp = mkMcpServer "stitch-mcp" "stitch-mcp";
          codebase_memory = {
            type = "local";
            command = [ "${codebase-memory-mcp}/bin/codebase-memory-mcp" ];
            enabled = true;
            timeout = 10000;
          };
        };

        agent = {
          workflow = {
            mode = "primary";
            temperature = 0.1;
            prompt = "{file:${promptPath "workflow"}}";
            permission = {
              read = "allow";
              glob = "allow";
              grep = "allow";
              list = "allow";
              edit = "deny";
              bash = {
                "*" = "deny";
                "git status*" = "allow";
                "git diff*" = "allow";
                "git log*" = "allow";
                "rg *" = "allow";
                "grep *" = "allow";
                "find *" = "allow";
                "ls *" = "allow";
                "pwd" = "allow";
                "cat *" = "allow";
                "mkdir -p .opencodestate*" = "allow";
                "tee .opencodestate/*" = "allow";
                "rm -f .opencodestate/*" = "allow";
              };
              task = {
                "*" = "deny";
                planner = "allow";
                architect = "allow";
                implementer = "allow";
                verifier = "allow";
                "failure-analyzer" = "allow";
              };
              "codebase_memory_*" = "allow";
            };
          };
          planner = {
            prompt = "{file:${promptPath "planner"}}";
            permission = readOnlyAgentPermissions;
          };
          architect = {
            prompt = "{file:${promptPath "architect"}}";
            permission = readOnlyAgentPermissions;
          };
          implementer = {
            prompt = "{file:${promptPath "implementer"}}";
            permission = {
              read = "allow";
              glob = "allow";
              grep = "allow";
              list = "allow";
              edit = "allow";
              bash = "ask";
              "codebase_memory_*" = "ask";
            };
          };
          verifier = {
            prompt = "{file:${promptPath "verifier"}}";
            permission = readOnlyAgentPermissions;
          };
          "failure-analyzer" = {
            prompt = "{file:${promptPath "failure-analyzer"}}";
            permission = readOnlyAgentPermissions;
          };
        };
      };

      generatedConfig = pkgs.writeText "phenix-opencode.json" (builtins.toJSON settings);

      wrappedOpencode = nix-wrapper-modules.wrappers.opencode.wrap {
        inherit pkgs;

        inherit settings;

        envDefault.OPENCODE_DISABLE_AUTOUPDATE = "1";
      };
    in
    {
      packages.default = wrappedOpencode;
      packages.generated-config = generatedConfig;

      checks.generated-config =
        pkgs.runCommand "phenix-opencode-generated-config-check"
          {
            nativeBuildInputs = [ pkgs.jq ];
          }
          ''
            jq -e '.command.flow.agent == "workflow"' ${generatedConfig}
            jq -e 'has("commands") | not' ${generatedConfig}
            jq -e 'has("prompts") | not' ${generatedConfig}
            jq -e '.agent.planner.permission.edit == "deny"' ${generatedConfig}
            jq -e '.agent.implementer.permission.edit == "allow"' ${generatedConfig}
            touch $out
          '';
    };
}
