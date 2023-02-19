{ ... }:

{
  services.code-server = {
    enable = true;
    extraEnvironment = {
      # change the extension gallery to Microsoft's one
      EXTENSIONS_GALLERY = "{ \"serviceUrl\": \"https://marketplace.visualstudio.com/_apis/public/gallery\", \"cacheUrl\": \"https://vscode.blob.core.windows.net/gallery/index\", \"itemUrl\": \"https://marketplace.visualstudio.com/items\", \"controlUrl\": \"\", \"recommendationsUrl\": \"\" }";
    };
    auth = "none";
    # hashedPassword = "";
    host = "0.0.0.0";
    user = "mzwing";
  };
}
