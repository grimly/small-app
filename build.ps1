mvn clean package dependency:copy-dependencies -DincludeScope=runtime
$allModules=jdeps --recursive --print-module-deps --ignore-missing-deps --multi-release 21 --class-path '.\target\dependency\*' .\target\api.jar
$modules = ( $allModules.Split(",") | Where-Object {$_.StartsWith("java")} ) -Join ","
docker build `
       --build-arg=MODULES=$modules `
       -f Dockerfile `
       -q `
       -t small-app:test `
       target
