vim.api.nvim_create_user_command('PackClean', function()
	local orphans = vim.iter(vim.pack.get()):filter(function(x) return not x.active end):map(function(x) return x
		.spec.name end):totable()
	if #orphans == 0 then
		vim.notify('No orphaned plugins to remove', vim.log.levels.INFO)
		return
	end
	vim.pack.del(orphans)
end, { desc = 'Remove plugins no longer in vim.pack.add()' })
