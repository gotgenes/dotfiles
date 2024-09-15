local helpers = require("helpers")
local M = {}

-- Matches CSS properties for HSL values like the following
-- (such as those created by shadcn/ui):
--
-- @layer base {
--   :root {
--     --background: 0 0% 100%;
--     --foreground: 222.2 84% 4.9%;
--     …
--   }
local digits_with_decimal_pattern = "%d+%.?%d*"
local hsl_custom_property_pattern = digits_with_decimal_pattern
  .. "%s"
  .. digits_with_decimal_pattern
  .. "%%%s"
  .. digits_with_decimal_pattern
  .. "%%"
local hsl_custom_property_matching_groups = "("
  .. digits_with_decimal_pattern
  .. ")"
  .. "%s"
  .. "("
  .. digits_with_decimal_pattern
  .. ")"
  .. "%%"
  .. "%s"
  .. "("
  .. digits_with_decimal_pattern
  .. ")"
  .. "%%"

M.opts = {
  highlighters = {
    tailwind_custom_hsl_properties = {
      pattern = function(buf_id)
        if vim.bo[buf_id].filetype ~= "css" then
          return nil
        end
        return hsl_custom_property_pattern
      end,
      group = function(_, _, data)
        local match = data.full_match
        local h, s, l = match:match(hsl_custom_property_matching_groups)
        local hex_color = helpers.hslToHex(tonumber(h), tonumber(s), tonumber(l))
        return require("mini.hipatterns").compute_hex_color_group(hex_color, "bg")
      end,
    },
  },
}

return M
