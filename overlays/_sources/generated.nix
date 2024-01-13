# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  fcitx5-pinyin-zhwiki = {
    pname = "fcitx5-pinyin-zhwiki";
    version = "20231205";
    src = fetchurl {
      url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.4/zhwiki-20231205.dict";
      sha256 = "sha256-crMmSqQ7QgmjgEG8QpvBgQYfvttCUsKYo8gHZGXIZmc=";
    };
  };
  fcitx5Theme = {
    pname = "fcitx5Theme";
    version = "ce244cfdf43a648d984719fdfd1d60aab09f5c97";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "fcitx5";
      rev = "ce244cfdf43a648d984719fdfd1d60aab09f5c97";
      fetchSubmodules = false;
      sha256 = "sha256-uFaCbyrEjv4oiKUzLVFzw+UY54/h7wh2cntqeyYwGps=";
    };
    date = "2022-10-05";
  };
  fishTheme = {
    pname = "fishTheme";
    version = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "fish";
      rev = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
      fetchSubmodules = false;
      sha256 = "sha256-Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
    };
    date = "2023-11-02";
  };
  foliateTheme = {
    pname = "foliateTheme";
    version = "40ae4528569d864cba8f4e64716c3361f7244209";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "foliate";
      rev = "40ae4528569d864cba8f4e64716c3361f7244209";
      fetchSubmodules = false;
      sha256 = "sha256-tpZj1/gV2TEdcequ+0EFz/3Hv4UN2dcdbJvT8a/i+hs=";
    };
    date = "2023-02-01";
  };
  palette = {
    pname = "palette";
    version = "823bd0179d491facf8ca368451dddb713926bc0e";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "palette";
      rev = "823bd0179d491facf8ca368451dddb713926bc0e";
      fetchSubmodules = false;
      sha256 = "sha256-rTWSA8HE9WfVRsbY4FUV12mvYimE+drOIUhcM/oX+D4=";
    };
    date = "2024-01-06";
  };
  qtcreatorTheme = {
    pname = "qtcreatorTheme";
    version = "ac6f95b71448b5dd473fed18fca42b88c9cc51e2";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "qtcreator";
      rev = "ac6f95b71448b5dd473fed18fca42b88c9cc51e2";
      fetchSubmodules = false;
      sha256 = "sha256-dTcEJyJTI58DDlzFeBrNGqjON9kdkifsB9rGrNceBUA=";
    };
    date = "2023-10-21";
  };
  river-unstable = {
    pname = "river-unstable";
    version = "6e9bd83e1d0e2132d2def338b51f66867cd88907";
    src = fetchFromGitHub {
      owner = "riverwm";
      repo = "river";
      rev = "6e9bd83e1d0e2132d2def338b51f66867cd88907";
      fetchSubmodules = true;
      sha256 = "sha256-9VUiK87/Fz3mzLJuj+qQPf0+mVFeYyb6n6vyctTu7cE=";
    };
    date = "2024-01-12";
  };
  ttf-ms-win10 = {
    pname = "ttf-ms-win10";
    version = "417eb232e8d037964971ae2690560a7b12e5f0d4";
    src = fetchFromGitHub {
      owner = "streetsamurai00mi";
      repo = "ttf-ms-win10";
      rev = "417eb232e8d037964971ae2690560a7b12e5f0d4";
      fetchSubmodules = false;
      sha256 = "sha256-UwkHlrSRaXhfoMlimyXFETV9yq1SbvUXykrhigf+wP8=";
    };
    date = "2021-02-10";
  };
  ttf-wps-fonts = {
    pname = "ttf-wps-fonts";
    version = "b3e935355afcfb5240bac5a99707ffecc35772a2";
    src = fetchFromGitHub {
      owner = "BannedPatriot";
      repo = "ttf-wps-fonts";
      rev = "b3e935355afcfb5240bac5a99707ffecc35772a2";
      fetchSubmodules = false;
      sha256 = "sha256-oRVREnE3qsk4gl1W0yFC11bHr+cmuOJe9Ah+0Csplq8=";
    };
    date = "2017-08-15";
  };
}
