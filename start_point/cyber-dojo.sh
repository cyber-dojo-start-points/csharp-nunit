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

# Instead of running the command
# dotnet restore --source /home/sandbox/.nuget/packages/
# create a symlink to an obj/ dir (created in the docker-image)
# This saves ~1.5 seconds.
ln -s /home/sandbox/dotnet_obj obj

dotnet test --no-restore --nologo
