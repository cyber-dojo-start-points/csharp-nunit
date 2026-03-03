# --------------------------------------------------------------
# Text files under /sandbox are automatically returned...
source ~/cyber_dojo_fs_cleaners.sh

function cyber_dojo_enter()
{
  : # 1. Only return _newly_ generated reports.
  #cyber_dojo_reset_dirs ${...}
}
function cyber_dojo_exit()
{
  : # 2. Remove text files we don't want returned.
  cyber_dojo_delete_dirs /sandbox/bin 
  cyber_dojo_delete_dirs /sandbox/obj
  #cyber_dojo_delete_files ...
}
cyber_dojo_enter
trap cyber_dojo_exit EXIT SIGTERM

# get the dlls
dotnet build \
  --configuration Release \
  --no-incremental \
  --source /home/sandbox/.nuget/packages/

cp /sandbox/bin/Release/net10.0/*.dll .

CSC_DLL=/usr/share/dotnet/sdk/10.0.103/Roslyn/bincore/csc.dll
NUNIT_PATH=/home/sandbox/.nuget/packages/nunit/4.3.2/lib/net8.0

dotnet "$CSC_DLL" \
  -target:library \
  -out:dojo.dll \
  -r:"${NUNIT_PATH}/nunit.framework.dll" \
  -r:/usr/share/dotnet/shared/Microsoft.NETCore.App/10.0.3/System.Private.CoreLib.dll \
  -r:/usr/share/dotnet/shared/Microsoft.NETCore.App/10.0.3/System.Runtime.dll \
  *.cs

dotnet test dojo.dll --nologo

# ~0.5 seconds faster:
#/home/sandbox/.dotnet/tools/nunit dojo.dll --noheader
