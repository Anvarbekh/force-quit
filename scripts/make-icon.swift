// Draws the app icon (a yellow ring with an X on a dark rounded square) as a
// 1024x1024 PNG. Plain shapes only, so the icon can be shared freely.
//
// Usage: swift scripts/make-icon.swift assets/icon-1024.png
import AppKit

let px = 1024
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: px, pixelsHigh: px,
                           bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
                           colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
rep.size = NSSize(width: px, height: px)

NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)

// Rounded square with a soft shadow, following the macOS icon grid.
let body = NSBezierPath(roundedRect: NSRect(x: 100, y: 100, width: 824, height: 824),
                        xRadius: 185, yRadius: 185)
NSGraphicsContext.saveGraphicsState()
let shadow = NSShadow()
shadow.shadowColor = NSColor.black.withAlphaComponent(0.35)
shadow.shadowBlurRadius = 24
shadow.shadowOffset = NSSize(width: 0, height: -10)
shadow.set()
NSColor(srgbRed: 0.13, green: 0.13, blue: 0.14, alpha: 1).setFill()
body.fill()
NSGraphicsContext.restoreGraphicsState()
NSGradient(starting: NSColor(srgbRed: 0.24, green: 0.24, blue: 0.26, alpha: 1),
           ending: NSColor(srgbRed: 0.08, green: 0.08, blue: 0.09, alpha: 1))!
    .draw(in: body, angle: -90)

// Yellow ring and X.
NSColor(srgbRed: 0.98, green: 0.77, blue: 0.18, alpha: 1).setStroke()
let ring = NSBezierPath(ovalIn: NSRect(x: 294, y: 294, width: 436, height: 436))
ring.lineWidth = 52
ring.stroke()

let cross = NSBezierPath()
cross.move(to: NSPoint(x: 414, y: 414))
cross.line(to: NSPoint(x: 610, y: 610))
cross.move(to: NSPoint(x: 414, y: 610))
cross.line(to: NSPoint(x: 610, y: 414))
cross.lineWidth = 46
cross.lineCapStyle = .round
cross.stroke()

NSGraphicsContext.restoreGraphicsState()
let output = URL(fileURLWithPath: CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "icon-1024.png")
try! rep.representation(using: .png, properties: [:])!.write(to: output)
print("Wrote \(output.path)")
