# allow ctrl t for command memory

function command_memory;
  set mycmd (cat ~/.config/fish/commands.txt /machine/opt/infrastructure/client/commands.txt 2>/dev/null | sed -e /^\$/d |  fzf)
  if test $status -eq 0;
	  set justcmd (string match -r '[^#]+' $mycmd)
	  set cmd_length (string length $justcmd)
	  commandline -r -- $mycmd
	  commandline -C $cmd_length
	  string match "#" $mycmd
  end
end

function command_memory_store;
	set lastcmd (history --max 1)
	set store (read -P "command and comment to store? " -c "$lastcmd # ")
    if test $status -eq 0;
		echo "ok, storing in ~/.config/fish/commands.txt" $store
		echo $store >>~/.config/fish/commands.txt
	end

end
bind \cT 'command_memory'
