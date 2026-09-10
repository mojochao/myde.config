# Personal GitHub identity (mojochao account).
#
# Auto-applied to any repo under ~/devel/repos/github.com/mojochao/ via the
# [includeIf "gitdir:..."] directive in this directory's `config`.
#
# ~/.ssh/config pins the work key on `Host github.com` with `AddKeysToAgent yes`,
# so ssh loads it into the agent and offers it *first* — GitHub accepts it and
# authenticates as the work account. IdentitiesOnly=yes does NOT prevent this:
# the work key is a config-supplied "explicit" identity, so it stays in the
# candidate list ahead of the -i key. IdentityAgent=none is what actually forces
# the personal key.
[core]
	sshCommand = ssh -i ~/.ssh/id_ed25519 -o IdentitiesOnly=yes -o IdentityAgent=none
