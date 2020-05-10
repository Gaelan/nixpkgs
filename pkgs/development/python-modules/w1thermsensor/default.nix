{ lib, buildPythonPackage, fetchPypi, pythonPackages }:

buildPythonPackage rec {
  pname = "w1thermsensor";
  version = "1.3.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "a53b339c8a99f4093d5da47c2295f571cbac9e5d72a0a1535f60f847b8c65df9";
  };

  propagatedBuildInputs = with pythonPackages; [ click ];

  doCheck = false; # Depends on kernel modules.

  meta = with lib; {
    homepage = "https://github.com/timofurrer/w1thermsensor";
    description = "A Python package and CLI tool to work with w1 temperature sensors like DS1822, DS18S20 & DS18B20 on the Raspberry Pi, Beagle Bone and other devices.";
    license = licenses.mit;
  };
}
