{ lib, stdenv, fetchurl, flex }:

stdenv.mkDerivation rec {
  pname = "libsepol";
  version = "3.0"; # remove -fcommon below after upgrading
  se_release = "20191204";
  se_url = "https://github.com/SELinuxProject/selinux/releases/download";

  outputs = [ "bin" "out" "dev" "man" ];

  src = fetchurl {
    url = "${se_url}/${se_release}/libsepol-${version}.tar.gz";
    sha256 = "0ygb6dh5lng91xs6xiqf5v0nxa68qmjc787p0s5h9w89364f2yjv";
  };

  nativeBuildInputs = [ flex ];

  makeFlags = [
    "PREFIX=$(out)"
    "BINDIR=$(bin)/bin"
    "INCDIR=$(dev)/include/sepol"
    "INCLUDEDIR=$(dev)/include"
    "MAN3DIR=$(man)/share/man/man3"
    "MAN8DIR=$(man)/share/man/man8"
    "SHLIBDIR=$(out)/lib"
  ];

  # Can remove -fcommon once we upgrade to 2020-07-10 / 3.1
  NIX_CFLAGS_COMPILE = "-Wno-error -fcommon";

  passthru = { inherit se_release se_url; };

  meta = with lib; {
    description = "SELinux binary policy manipulation library";
    homepage = "http://userspace.selinuxproject.org";
    platforms = platforms.linux;
    maintainers = [ maintainers.phreedom ];
    license = lib.licenses.gpl2;
  };
}
