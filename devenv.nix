{pkgs, ...}:{
  packages = with pkgs;[
    lua-language-server
    luajit
    luajitPackages.luacheck
  ];
}
