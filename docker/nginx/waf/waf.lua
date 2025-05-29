-- waf.lua

-- Block user agents
local blacklisted_ua = { "sqlmap", "nikto", "fuzz" }
local ua = ngx.var.http_user_agent or ""
for _, bad in ipairs(blacklisted_ua) do
    if ua:lower():find(bad) then
        ngx.exit(ngx.HTTP_FORBIDDEN)
    end
end

-- Simple SQLi patterns
local sqli_patterns = {
    "' or '1'='1",
    "union%s+select",
    "select%s+.*from",
    "insert%s+into",
    "drop%s+table",
    "information_schema",
    "sleep%(",
    "benchmark%(",
    "or%s+1=1",
    "and%s+1=1",
    "xp_cmdshell",
    "exec%s+xp_",
    "update%s+.*set",
    "delete%s+from"
}

-- Simple XSS patterns
local xss_patterns = {
    "<script",
    "onerror%s*=",
    "onload%s*=",
    "alert%s*%(",
    "document%.cookie",
    "<img%s+",
    "<svg",
    "javascript:",
    "vbscript:",
    "expression%s*%("
}

-- Helper: check patterns in a string
local function matches_patterns(str, patterns)
    str = str:lower()
    for _, pat in ipairs(patterns) do
        if str:find(pat) then
            return true
        end
    end
    return false
end

-- Check query string, POST body, cookies for SQLi/XSS
local args = ngx.req.get_uri_args()
for k, v in pairs(args) do
    if type(v) == "table" then v = table.concat(v, " ") end
    if matches_patterns(k, sqli_patterns) or matches_patterns(v, sqli_patterns) then
        ngx.exit(ngx.HTTP_FORBIDDEN)
    end
    if matches_patterns(k, xss_patterns) or matches_patterns(v, xss_patterns) then
        ngx.exit(ngx.HTTP_FORBIDDEN)
    end
end

-- Check POST body
if ngx.req.get_method() == "POST" then
    ngx.req.read_body()
    local post_args = ngx.req.get_post_args()
    for k, v in pairs(post_args) do
        if type(v) == "table" then v = table.concat(v, " ") end
        if matches_patterns(k, sqli_patterns) or matches_patterns(v, sqli_patterns) then
            ngx.exit(ngx.HTTP_FORBIDDEN)
        end
        if matches_patterns(k, xss_patterns) or matches_patterns(v, xss_patterns) then
            ngx.exit(ngx.HTTP_FORBIDDEN)
        end
    end
end

-- Check cookies
local cookie = ngx.var.http_cookie or ""
if matches_patterns(cookie, sqli_patterns) or matches_patterns(cookie, xss_patterns) then
    ngx.exit(ngx.HTTP_FORBIDDEN)
end
