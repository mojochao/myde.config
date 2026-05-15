# Use starship for portable shell prompt.
# docs: https://starship.rs/
# repo: https://github.com/starship/starship
import shutil
if shutil.which('starship'):
    execx($(starship init xonsh))

if shutil.which('atuin'):
    execx($(atuin init xonsh))
