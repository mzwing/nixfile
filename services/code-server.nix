{ ... }:

{
  services.code-server = {
    enable = true;
    # change the extension gallery to Microsoft's one
    extraEnvironment.EXTENSIONS_GALLERY = "{ \"serviceUrl\": \"https://marketplace.visualstudio.com/_apis/public/gallery\", \"cacheUrl\": \"https://vscode.blob.core.windows.net/gallery/index\", \"itemUrl\": \"https://marketplace.visualstudio.com/items\", \"controlUrl\": \"\", \"recommendationsUrl\": \"\" }";
    auth = "none";
    # hashedPassword = "$argon2i$v=19$m=4096,t=3,p=1$DleGMZw4OUHH74Xt71t4Ig$oqn3gV6L8WEap0N0UYoRZs7HS77Bid/PkiDPa5mn6Xc";
    host = "0.0.0.0";
    user = "mzwing";
  };
}
