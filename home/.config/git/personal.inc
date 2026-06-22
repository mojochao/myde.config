# Personal GitHub identity (mojochao account).
#
# Auto-applied to any repo under ~/devel/repos/github.com/mojochao/ via the
# [includeIf "gitdir:..."] directive in this directory's `config`. Forces the
# personal SSH key instead of the work key that ~/.ssh/config sets for github.com.
# IdentitiesOnly=yes makes ssh ignore the ~/.ssh/config IdentityFile and use only
# the -i key.
[core]
	sshCommand = ssh -i ~/.ssh/id_ed25519 -o IdentitiesOnly=yes
