const git_hash = staticExec "git rev-parse HEAD"
echo("Git Revision:\t", git_hash)
