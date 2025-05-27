-- waf.lua
local blacklisted_ua = { "sqlmap", "nikto", "fuzz" }
local ua = ngx.var.http_user_agent or ""

for _, bad in ipairs(blacklisted_ua) do
    if ua:lower():find(bad) then
        ngx.exit(ngx.HTTP_FORBIDDEN)
    end
end
