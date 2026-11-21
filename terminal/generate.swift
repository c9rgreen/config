// Generates the Merino Terminal.app profiles. Usage: swift generate.swift ~/.config/terminal
import AppKit

func c(_ hex: String) -> NSColor {
    let v = Int(hex.dropFirst(), radix: 16)!
    return NSColor(srgbRed: CGFloat((v >> 16) & 0xff) / 255, green: CGFloat((v >> 8) & 0xff) / 255,
                   blue: CGFloat(v & 0xff) / 255, alpha: 1)
}
func arch(_ o: Any) -> Data { try! NSKeyedArchiver.archivedData(withRootObject: o, requiringSecureCoding: false) }

let ansi = ["Black", "Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White"]
let font = NSFont(name: "BerkeleyMono-Regular", size: 15) ?? NSFont(name: "Berkeley Mono", size: 15)
    ?? NSFont.monospacedSystemFont(ofSize: 15, weight: .regular)
print("font:", font.fontName)

func write(_ name: String, bg: String, fg: String, cursor: String, sel: String, pal: [String], out: String) {
    var d: [String: Any] = [
        "name": name, "type": "Window Settings", "ProfileCurrentVersion": 2.07,
        "BackgroundColor": arch(c(bg)), "TextColor": arch(c(fg)), "TextBoldColor": arch(c(fg)),
        "CursorColor": arch(c(cursor)), "SelectionColor": arch(c(sel)),
        "Font": arch(font), "FontAntialias": true, "UseBrightBold": false,
        "columnCount": 120, "rowCount": 36,
    ]
    for (i, n) in ansi.enumerated() {
        d["ANSI\(n)Color"] = arch(c(pal[i]))
        d["ANSIBright\(n)Color"] = arch(c(pal[i + 8]))
    }
    let data = try! PropertyListSerialization.data(fromPropertyList: d, format: .xml, options: 0)
    try! data.write(to: URL(fileURLWithPath: out))
}

let dir = CommandLine.arguments[1]
write("Merino Dark", bg: "#0d1117", fg: "#e6edf3", cursor: "#2f81f7", sel: "#1b3e71",
      pal: ["#484f58", "#ff7b72", "#3fb950", "#d29922", "#58a6ff", "#bc8cff", "#39c5cf", "#b1bac4",
            "#6e7681", "#ffa198", "#56d364", "#e3b341", "#79c0ff", "#d2a8ff", "#56d4dd", "#ffffff"],
      out: dir + "/Merino Dark.terminal")
write("Merino Light", bg: "#ffffff", fg: "#1f2328", cursor: "#0969da", sel: "#b6d8ff",
      pal: ["#24292f", "#cf222e", "#116329", "#9d5c00", "#0969da", "#8250df", "#1b7c83", "#6e7781",
            "#57606a", "#a40e26", "#1a7f37", "#c47a00", "#218bff", "#a475f9", "#3192aa", "#8c959f"],
      out: dir + "/Merino Light.terminal")
