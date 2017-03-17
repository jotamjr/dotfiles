-- {{{
-- Based on the the Clock Rings code from londonali1010 (2009) and made some little changes
-- }}}

require 'cairo'

color_t = {
  bg_low    = 0xffffff,
  bg_normal = 0xffffff,
  bg_high   = 0xffffff,
  bg_alpha  = 0.2,
  fg_low    = 0xd7d7d7,
  fg_normal = 0x5dade2,
  fg_high   = 0xec7063,
  fg_alpha  = 0.6
}

halo_t = {
  {
    name = 'cpu',
    arg = 'cpu1',
    max = 100,
    x = 155, y = 103,
    radius = 36,
    thickness = 7,
    start_angle = 0,
    end_angle = 360,
  },
  {
    name = 'cpu',
    arg = 'cpu2',
    max = 100,
    x = 155, y = 103,
    radius = 20,
    thickness = 14,
    start_angle = 0,
    end_angle = 360
  },
  {
    name = 'memperc',
    arg = '/',
    max = 100,
    x = 105, y = 870,
    radius = 59,
    thickness = 3,
    start_angle = 0,
    end_angle = 360
  },
  {
    name = 'fs_used_perc',
    arg = '/',
    max = 100,
    x = 105, y = 870,
    radius = 51,
    thickness = 6,
    start_angle = 0,
    end_angle = 360
  },
  {
    name = 'fs_used_perc',
    arg = '/home',
    max = 100,
    x = 105, y = 870,
    radius = 43,
    thickness = 3,
    start_angle = 0,
    end_angle = 360
  },
  {
    name = 'fs_used_perc',
    arg = '/boot',
    max = 100,
    x = 105, y = 870,
    radius = 35,
    thickness = 6,
    start_angle = 0,
    end_angle = 360
  },
}

function rgb_to_r_g_b(color,alpha)
  return ((color / 0x10000) % 0x100) / 255., ((color / 0x100) % 0x100) / 255., (color % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
  local w,h=conky_window.width, conky_window.height

  local xc, yc, ring_r, ring_w, sa, ea = pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
  local bgc, bga, fgc, fga

  local angle_0 = sa*(2*math.pi/360)-math.pi/2
  local angle_f = ea*(2*math.pi/360)-math.pi/2
  local t_arc = t*(angle_f-angle_0)

  bgc = color_t['bg_normal']
  bga = color_t['bg_alpha']
  local fixc = rgb_to_r_g_b(bgc, bga)

  -- Draw background ring
  cairo_arc(cr, xc, yc, ring_r, angle_0, angle_f)
  cairo_set_source_rgba(cr, rgb_to_r_g_b(bgc,bga))
  cairo_set_line_width(cr, ring_w)
  cairo_stroke(cr)

  fgc = color_t['fg_low']

  if t >= 0.3 and t < 0.85 then
    fgc = color_t['fg_normal']
  elseif t >= 0.85 then
    fgc = color_t['fg_high']
  end
  fga = color_t['fg_alpha']

  cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
  cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
  cairo_stroke(cr)
end

function conky_clock_rings()
  local function setup_rings(cr, pt)
    local str = ''
    local value = 0

    str = string.format('${%s %s}', pt['name'], pt['arg'])
    str = conky_parse(str)

    value = tonumber(str)
    if value == nil then value = 0 end

    pct = value/pt['max']

    draw_ring(cr, pct, pt)
  end

  if conky_window == nil then return end

  local cs = cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)

  local cr = cairo_create(cs)

  local updates = conky_parse('${updates}')
  update_num = tonumber(updates)

  if update_num > 5 then
    for i in pairs(halo_t) do
      setup_rings(cr, halo_t[i])
    end
  end
end
