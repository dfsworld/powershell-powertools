# powershell-powertools
Powershell snippet to change build number on AssemblyInfo.cs
(more to come)

Usage:

in "Pre-build event command line, put: "
powershell $(SolutionDir)\<path to file>\setAssemblyVer.ps1 $(ProjectDir)\Properties\AssemblyInfo.cs
