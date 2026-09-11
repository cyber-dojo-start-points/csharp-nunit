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
# One version of each package is installed, and those versions move, so each
# is found rather than written out. The framework directory under lib/ stays
# named because a package publishes several and only one is wanted.
ln -s $(echo ~/.nuget/packages/nunit/*/lib/net8.0/nunit.framework.dll) nunit.framework.dll
#in order to use legacy asserts eg: AreEqual(42, 42);
# add on top of the .cs file: using static NUnit.Framework.Legacy.ClassicAssert;
ln -s $(echo ~/.nuget/packages/nunit/*/lib/net8.0/nunit.framework.legacy.dll) nunit.framework.legacy.dll

# The two mocking libraries. Both are built on Castle DynamicProxy, which is
# what Castle.Core.dll is, and both use the same version of it.
ln -s $(echo ~/.nuget/packages/moq/*/lib/net6.0/Moq.dll) Moq.dll
ln -s $(echo ~/.nuget/packages/nsubstitute/*/lib/net6.0/NSubstitute.dll) NSubstitute.dll
ln -s $(echo ~/.nuget/packages/castle.core/*/lib/net6.0/Castle.Core.dll) Castle.Core.dll

# -nowarn:1701,1702 below: Moq was built against an older System.Linq.Expressions
# than this runtime carries. The mismatch is harmless, there is nothing you can
# do about it, and without this the warning appears every time you run the tests.
# One .NET SDK and one shared framework are installed, and their versions
# move as .NET is updated, so both are found rather than written out. They
# carry different versions, so they are found separately.
readonly CSC=$(echo /usr/share/dotnet/sdk/*/Roslyn/bincore/csc.dll)
readonly SHARED=$(echo /usr/share/dotnet/shared/Microsoft.NETCore.App/*)

time (dotnet ${CSC} \
  -target:library \
  -nologo \
  -out:dojo.dll \
  -nowarn:1701,1702 \
  -r:nunit.framework.dll \
  -r:nunit.framework.legacy.dll \
  -r:Moq.dll \
  -r:NSubstitute.dll \
  -r:Castle.Core.dll \
  -r:${SHARED}/System.Private.CoreLib.dll \
  -r:${SHARED}/System.Runtime.dll \
  -r:${SHARED}/System.Linq.dll \
  -r:${SHARED}/System.Linq.Expressions.dll \
  -r:${SHARED}/System.Collections.dll \
  -r:${SHARED}/System.Text.RegularExpressions.dll \
  $(find . -name '*.cs') && /home/sandbox/.dotnet/tools/nunit dojo.dll --noheader --noresult --nocolor )
