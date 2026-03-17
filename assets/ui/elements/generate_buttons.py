#!/usr/bin/env python3
"""
Generate button mockups for Emotion Cards game UI.
Creates PNG files for various button types with different emotion family color schemes.
"""

from PIL import Image, ImageDraw, ImageFont
import os

# Output directory
OUTPUT_DIR = "/Users/binhu2208/.openclaw/agents/yoshi/workspace/project/assets/ui/elements"

# Color schemes per emotion family
EMOTION_COLORS = {
    "warmth": {
        "primary": "#E8A87C",
        "hover": "#F0C49A", 
        "pressed": "#D4946A",
        "text": "#4A3728",
        "border": "#C98B5E"
    },
    "shadow": {
        "primary": "#5D5D7A",
        "hover": "#7878A0",
        "pressed": "#4A4A62",
        "text": "#E8E8F0",
        "border": "#45456A"
    },
    "fire": {
        "primary": "#E85D4C",
        "hover": "#F07060",
        "pressed": "#C94A38",
        "text": "#FFFFFF",
        "border": "#C94A38"
    },
    "storm": {
        "primary": "#5B9BD5",
        "hover": "#70ABDE",
        "pressed": "#4A82B8",
        "text": "#FFFFFF",
        "border": "#4A82B8"
    },
    "neutral": {
        "primary": "#6B6B7A",
        "hover": "#80808D",
        "pressed": "#56565F",
        "text": "#FFFFFF",
        "border": "#56565F"
    }
}

# Button dimensions
BUTTON_SIZES = {
    "action": {"width": 280, "height": 96, "radius": 16},  # 2x for retina
    "menu": {"width": 400, "height": 112, "radius": 24},
    "dialog": {"width": 200, "height": 80, "radius": 12}
}

# Font sizes (2x)
FONT_SIZES = {
    "action": 32,
    "menu": 40,
    "dialog": 28
}


def hex_to_rgb(hex_color):
    """Convert hex color to RGB tuple."""
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))


def create_button(label, emotion, button_type="action", state="normal"):
    """Create a button image with specified parameters."""
    colors = EMOTION_COLORS[emotion]
    size = BUTTON_SIZES[button_type]
    
    # Select color based on state
    if state == "normal":
        bg_color = colors["primary"]
        border_color = colors["border"]
    elif state == "hover":
        bg_color = colors["hover"]
        border_color = colors["border"]
    elif state == "pressed":
        bg_color = colors["pressed"]
        border_color = colors["pressed"]
    else:  # disabled
        rgb = hex_to_rgb(colors["primary"])
        bg_color = (rgb[0], rgb[1], rgb[2], 128)
        border_color = hex_to_rgb(colors["border"])
    
    # Convert hex to RGB tuple if needed
    if isinstance(bg_color, str):
        bg_color = hex_to_rgb(bg_color) + (255,)
    elif len(bg_color) == 3:
        bg_color = bg_color + (255,)
    
    if isinstance(border_color, str):
        border_color = hex_to_rgb(border_color)
    
    # Create image with RGBA for transparency
    width, height = size["width"], size["height"]
    img = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Draw rounded rectangle
    radius = size["radius"]
    draw.rounded_rectangle(
        [(0, 0), (width - 1, height - 1)],
        radius=radius,
        fill=bg_color,
        outline=border_color,
        width=4
    )
    
    # Draw text
    try:
        # Try to use a nice font, fall back to default
        font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", FONT_SIZES[button_type])
    except:
        font = ImageFont.load_default()
    
    # Calculate text position (centered)
    # Get text bounding box
    bbox = draw.textbbox((0, 0), label, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    text_x = (width - text_width) // 2
    text_y = (height - text_height) // 2 - 2
    
    text_color = hex_to_rgb(colors["text"])
    draw.text((text_x, text_y), label, fill=text_color, font=font)
    
    return img


def create_button_with_icon(label, emotion, button_type="action", state="normal", icon_symbol=None):
    """Create a button image with an optional icon symbol."""
    colors = EMOTION_COLORS[emotion]
    size = BUTTON_SIZES[button_type]
    
    # Select color based on state
    if state == "normal":
        bg_color = colors["primary"]
        border_color = colors["border"]
    elif state == "hover":
        bg_color = colors["hover"]
        border_color = colors["border"]
    elif state == "pressed":
        bg_color = colors["pressed"]
        border_color = colors["pressed"]
    else:  # disabled
        rgb = hex_to_rgb(colors["primary"])
        bg_color = (rgb[0], rgb[1], rgb[2], 128)
        border_color = hex_to_rgb(colors["border"])
    
    # Convert hex to RGB tuple if needed
    if isinstance(bg_color, str):
        bg_color = hex_to_rgb(bg_color) + (255,)
    elif len(bg_color) == 3:
        bg_color = bg_color + (255,)
    
    if isinstance(border_color, str):
        border_color = hex_to_rgb(border_color)
    
    width, height = size["width"], size["height"]
    img = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    radius = size["radius"]
    draw.rounded_rectangle(
        [(0, 0), (width - 1, height - 1)],
        radius=radius,
        fill=bg_color,
        outline=border_color,
        width=4
    )
    
    # Try to use font
    try:
        font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", FONT_SIZES[button_type])
    except:
        font = ImageFont.load_default()
    
    text_color = hex_to_rgb(colors["text"])
    
    if icon_symbol:
        # Draw icon on the left
        icon_bbox = draw.textbbox((0, 0), icon_symbol, font=font)
        icon_width = icon_bbox[2] - icon_bbox[0]
        
        # Center everything together
        full_text = icon_symbol + " " + label
        full_bbox = draw.textbbox((0, 0), full_text, font=font)
        full_width = full_bbox[2] - full_bbox[0]
        
        start_x = (width - full_width) // 2
        text_y = (height - (font.size)) // 2 - 2
        
        draw.text((start_x, text_y), icon_symbol, fill=text_color, font=font)
        
        # Draw label after icon
        label_x = start_x + icon_width + 8
        draw.text((label_x, text_y), label, fill=text_color, font=font)
    else:
        # Just center the label
        bbox = draw.textbbox((0, 0), label, font=font)
        text_width = bbox[2] - bbox[0]
        text_height = bbox[3] - bbox[1]
        text_x = (width - text_width) // 2
        text_y = (height - text_height) // 2 - 2
        draw.text((text_x, text_y), label, fill=text_color, font=font)
    
    return img


def main():
    """Generate all button mockups."""
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    # Action buttons (using Fire emotion for attack, Storm for defend, etc.)
    print("Creating action buttons...")
    
    # Attack button (Fire)
    btn = create_button_with_icon("ATTACK", "fire", "action", "normal", "⚔")
    btn.save(f"{OUTPUT_DIR}/button-attack.png")
    print("  - button-attack.png")
    
    # Defend button (Storm)
    btn = create_button_with_icon("DEFEND", "storm", "action", "normal", "🛡")
    btn.save(f"{OUTPUT_DIR}/button-defend.png")
    print("  - button-defend.png")
    
    # Play Card button (Shadow)
    btn = create_button_with_icon("PLAY CARD", "shadow", "action", "normal", "🎴")
    btn.save(f"{OUTPUT_DIR}/button-play-card.png")
    print("  - button-play-card.png")
    
    # End Turn button (Warmth)
    btn = create_button_with_icon("END TURN", "warmth", "action", "normal", "✓")
    btn.save(f"{OUTPUT_DIR}/button-end-turn.png")
    print("  - button-end-turn.png")
    
    # Menu button (Neutral - common for all menu buttons)
    btn = create_button("NEW GAME", "neutral", "menu", "normal")
    btn.save(f"{OUTPUT_DIR}/button-menu.png")
    print("  - button-menu.png")
    
    # Also create variants for other menu buttons
    btn_cont = create_button("CONTINUE", "neutral", "menu", "normal")
    btn_cont.save(f"{OUTPUT_DIR}/button-continue.png")
    print("  - button-continue.png")
    
    btn_settings = create_button("SETTINGS", "neutral", "menu", "normal")
    btn_settings.save(f"{OUTPUT_DIR}/button-settings.png")
    print("  - button-settings.png")
    
    btn_quit = create_button("QUIT", "neutral", "menu", "normal")
    btn_quit.save(f"{OUTPUT_DIR}/button-quit.png")
    print("  - button-quit.png")
    
    # Dialog buttons
    btn_yes = create_button("YES", "fire", "dialog", "normal")
    btn_yes.save(f"{OUTPUT_DIR}/button-yes.png")
    print("  - button-yes.png")
    
    btn_no = create_button("NO", "shadow", "dialog", "normal")
    btn_no.save(f"{OUTPUT_DIR}/button-no.png")
    print("  - button-no.png")
    
    btn_cancel = create_button("CANCEL", "neutral", "dialog", "normal")
    btn_cancel.save(f"{OUTPUT_DIR}/button-cancel.png")
    print("  - button-cancel.png")
    
    print(f"\nAll buttons created in: {OUTPUT_DIR}")
    print("Done!")


if __name__ == "__main__":
    main()
