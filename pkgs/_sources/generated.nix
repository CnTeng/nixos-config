# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
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
      owner = "dv-anomaly";
      repo = "ttf-wps-fonts";
      rev = "b3e935355afcfb5240bac5a99707ffecc35772a2";
      fetchSubmodules = false;
      sha256 = "sha256-oRVREnE3qsk4gl1W0yFC11bHr+cmuOJe9Ah+0Csplq8=";
    };
    date = "2017-08-15";
  };
}
