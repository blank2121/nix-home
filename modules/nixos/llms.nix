 { ... }:
 {
    services.ollama = {
        enable = true;
        environmentVariables = {
            OLLAMA_ORIGINS = "app://obsidian.md*";
        };
        # null default, rocm = acceleration for AMD
        acceleration = "rocm";
    };
 }
