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
  : # 2. Remove new text files we don't want returned.
  cyber_dojo_delete_dirs /sandbox/bin 
  cyber_dojo_delete_dirs /sandbox/obj
  cyber_dojo_delete_files TestResult.xml
}
cyber_dojo_enter
trap cyber_dojo_exit EXIT SIGTERM

#FALLBACK, SLOWER ~5.4s: 
# comment in the next line if compilation fails
#time (ln -s /home/sandbox/dotnet_obj obj && dotnet test --no-restore --nologo ) ; exit

#FAST ~1.2s: 
ln -s ~/.nuget/packages/nunit/4.3.2/lib/net8.0/nunit.framework.dll nunit.framework.dll
#use legacy asserts eg: AreEqual(42, 42);
# needs on top of file: using static NUnit.Framework.Legacy.ClassicAssert;
ln -s ~/.nuget/packages/nunit/4.3.2/lib/net8.0/nunit.framework.legacy.dll nunit.framework.legacy.dll 

time (dotnet /usr/share/dotnet/sdk/10.0.103/Roslyn/bincore/csc.dll \
  -target:library \
  -nologo \
  -out:dojo.dll \
  -r:nunit.framework.dll \
  -r:nunit.framework.legacy.dll \
  -r:/usr/share/dotnet/shared/Microsoft.NETCore.App/10.0.3/System.Private.CoreLib.dll \
  -r:/usr/share/dotnet/shared/Microsoft.NETCore.App/10.0.3/System.Runtime.dll \
  *.cs && /home/sandbox/.dotnet/tools/nunit dojo.dll --noheader --noresult --nocolor )
