function Image(el)
  -- Check if the src doesn't already start with a slash or URL
  if not el.src:match("^/") and not el.src:match("^https?://") then
    el.src = "/static/" .. el.src
  end
  return el
end