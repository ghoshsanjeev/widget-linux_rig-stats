#!/bin/bash
set -e

echo "=========================================================="
echo "Configuring Draggable Ultra-Transparent Glass Panel"
echo "=========================================================="

mkdir -p ~/.config/conky

echo "[1/1] Rewriting configuration for clean cyberpunk aesthetic..."
cat << 'EOF' > ~/.config/conky/conky.conf
conky.config = {
    alignment = 'top_right',
    background = false,
    border_width = 1,
    cpu_avg_samples = 2,
    default_color = '#ffffff',
    default_outline_color = '#ffffff',
    default_shade_color = '#ffffff',
    double_buffer = true,
    draw_borders = false,
    draw_graph_borders = false,
    draw_outline = false,
    draw_shades = false,
    extra_newline = false,
    font = 'DejaVu Sans Mono:size=9',
    gap_x = 25,
    gap_y = 55,
    minimum_height = 100,
    minimum_width = 350,
    net_avg_samples = 2,
    no_buffers = true,
    out_to_console = false,
    out_to_ncurses = false,
    out_to_stderr = false,
    out_to_x = true,
    
    -- SUPER-KEY DRAGGABLE & HIGH TRANSPARENCY
    own_window = true,
    own_window_class = 'Conky',
    own_window_type = 'normal',        -- Enabled 'normal' to allow window manager dragging
    own_window_transparent = false,    
    own_window_argb_visual = true,     
    own_window_argb_value = 40,        -- Dropped to 40 (~15% opacity) for a subtle ghost-glass effect
    own_window_colour = '#0A0A10',     -- Deep cyber-space tint backing
    own_window_hints = 'undecorated,above,sticky,skip_taskbar,skip_pager', -- No 'unclickable' hint
    
    show_graph_range = false,
    show_graph_scale = false,
    stippled_borders = 0,
    update_interval = 1.5,
    uppercase = false,
    use_spacer = 'none',
    use_xft = true,
}

conky.text = [[
${color #00FFCC}┌── RIG ──┐ ${color}${exec cat /sys/devices/virtual/dmi/id/board_name | cut -c 1-10} • ${exec grep -m1 "model name" /proc/cpuinfo | cut -d: -f2 | sed 's/AMD //g' | sed 's/Ryzen //g' | cut -c 2-10} • ${exec nvidia-smi --query-gpu=name --format=csv,noheader | sed 's/NVIDIA //g' | cut -c 1-12}
${color #00FFCC}├── CPU ──┤ ${color}Load: ${color #FFFF00}${cpu cpu0}% ${color}${alignr}Bar: ${color #00FFCC}${cpubar cpu0 5,140}
${color #00FFCC}├── RAM ──┤ ${color}Used: ${color #FFFF00}${memperc}%${color} (${mem}) ${alignr}Bar: ${color #00FFCC}${membar 5,140}
${color #00FFCC}└── GPU ──┘ ${color}Load: ${color #FFFF00}${execi 2 nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits}%${color} @ ${color #FFFF00}${execi 2 nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits}°C ${alignr}VRAM: ${color #00FFCC}${execi 3 nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits}MB
]]
EOF

echo "Launching the minimalist layout..."
killall conky 2>/dev/null || true
conky -c ~/.config/conky/conky.conf &

echo "=========================================================="
echo "SUCCESS: Your sleek ghost-glass HUD is live!"
echo "HOW TO DRAG: Hold down the 'Super' (Windows) key, then"
echo "click anywhere inside the widget text box to move it."
echo "=========================================================="

