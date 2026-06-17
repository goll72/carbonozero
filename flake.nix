{
  description = "Monitoramento de emissões de carbono corporativas";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    lefthook-nix.url = "github:sudosubin/lefthook.nix";
    lefthook-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = ["x86_64-linux"];

      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      perSystem = {
        config,
        pkgs,
        lib,
        system,
        ...
      }: let
        py = pkgs.python313Packages;
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            py.python

            pkgs.uv
            pkgs.ty
            pkgs.ruff

            pkgs.pgcli
            pkgs.sqlfluff
            pkgs.postgresql_18
          ];

          shellHook = ''
            REPO_ROOT=$(git rev-parse --show-toplevel)

            cd "$REPO_ROOT"
            
            uv sync
            . .venv/bin/activate

            mkdir -p db/logs

            LOG="db/logs/$(date +'%Y%m%dT%H%M%S.log')"
            
            if ! [ -e "$PGDATA" ]; then
              pg_ctl -l "$LOG" initdb

              ln -sf ../postgresql.conf "$PGDATA/postgresql.conf"
              pg_ctl -l "$LOG" start
              
              PGUSER= psql -d postgres \
                -c "CREATE USER $PGUSER;" \
                -c "CREATE DATABASE $PGDATABASE;" \
                -c "GRANT ALL PRIVILEGES ON DATABASE $PGDATABASE TO $PGUSER;"

              PGUSER= psql -c "GRANT ALL PRIVILEGES ON SCHEMA public TO $PGUSER;"
            else
              ln -sf ../postgresql.conf "$PGDATA/postgresql.conf"
              pg_ctl -l "$LOG" restart
            fi
          '';

          # Use Unix socket instead of TCP connection
          PGHOST = "/tmp";
          # PostgreSQL Data directory
          PGDATA = "db/datadir";
          
          PGUSER = "carbonozero";
          PGDATABASE = "carbonozero";

          LANG = "C.UTF-8";
          LC_ALL = "C.UTF-8";
        };
      };
    };
}
