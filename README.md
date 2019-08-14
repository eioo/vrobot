# vrobot

⚠ _Work in progress. Windows only supported._

Basic desktop automation functions for v lang.

## Plans

- Screen related functions such as `screen_size()`, `get_pixel_color()`...
- Keyboard simulation and hooks

## Example

```go
import vrobot

pos := vrobot.get_mouse_position()
println('Current mouse position: $pos.x, $pos.y')

// Moves mouse twice returning to starting position
vrobot.move_mouse_smooth(pos.x + 100, pos.y + 100, 1000)
vrobot.move_mouse_smooth_rel(-100, -100, 500)

// Drags from 100, 100 to 150, 150 with left click
vrobot.move_mouse(100, 100)
vrobot.drag(150, 150)
```

🖱️ Valid mouse buttons are: `left`, `right`, `middle`

## Functions

### `get_mouse_pos() { x, y int }`

Returns struct with current mouse position.

### `click(button string)`

Clicks with mouse.

### `double_click(button string)`

Double clicks.

### `drag(x, y int)`

Drags mouse (left) to specified position.

### `drag_rel(offset_x, offset_y int)`

Drags mouse (left) relative to current position.

### `move_mouse(x, y int)`

Moves mouse to x, y.

### `move_mouse_rel(offset_x, offset_y, duration_ms int)`

Moves mouse relative to current position.

### `move_mouse_smooth(dest_x, dest_y, duration_ms int)`

Moves mouse smoothly to dest_x, dest_y in duration_ms.

### `move_mouse_smooth_rel(offset_x, offset_y, duration_ms int)`

Moves mouse smoothly, relative to current position in duration_ms.
