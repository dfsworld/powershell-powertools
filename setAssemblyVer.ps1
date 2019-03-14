param (
[string] $filename = "AssemblyInfo.cs"
)
$pattern = '\[assembly: AssemblyVersion\("(.*)"\)\]'
$year = (get-date).Year
$days = "000" + (New-TimeSpan -Start 01/01/$year -end (get-date)).Days
$year = $year-2000;
$days = $days.Substring($days.Length-3,3)
$build = "$year$days"

(Get-Content $filename) | ForEach-Object{
    if($_ -match $pattern){
        # We have found the matching line
        # Edit the version number and put back.
        $fileVersion = [version]$matches[1]
        $revision = 0;
        if ($fileVersion.Build -like $build) {
        $revision = $fileVersion.Revision +1;
        }

        $newVersion = "{0}.{1}.{2}.{3}" -f $fileVersion.Major, $fileVersion.Minor, ($build), $revision
        '[assembly: AssemblyVersion("{0}")]' -f $newVersion
    } else {
        # Output line as is
        $_
    }
} | Set-Content $filename