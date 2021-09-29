require("mkdir")

if vim.fn.has("wsl") == true then
  vim.cmd(
    [[
        " Change to suit mount point
        let s:clip = '/mnt/c/Windows/System32/clip.exe'   

        if executable(s:clip)
            augroup WSLYank
                autocmd!
                autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
            augroup END
        endif
    ]]
  )
end
