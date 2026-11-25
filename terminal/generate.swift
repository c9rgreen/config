// Generates the Cyclotron Terminal.app profiles; colors match ghostty/themes/cyclotron_*. Usage: swift generate.swift ~/.config/terminal
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
write("Cyclotron Dark", bg: "#1a1813", fg: "#cfcec3", cursor: "#fd8760", sel: "#3a382e",
      pal: ["#323028", "#fe7a6a", "#77b884", "#c8b362", "#75a6cf", "#a690c9", "#64c3bd", "#cfcec3",
            "#c4beaf", "#fd8760", "#77b884", "#c8b362", "#75a6cf", "#eb94b5", "#64c3bd", "#cfcec3"],
      out: dir + "/Cyclotron Dark.terminal")
write("Cyclotron Light", bg: "#f2f0e8", fg: "#2a2920", cursor: "#b84820", sel: "#cbc8bc",
      pal: ["#d4d1c7", "#b83a2e", "#3a7a4a", "#8a7520", "#3a6a90", "#6a558a", "#188580", "#2a2920",
            "#4a4538", "#b84820", "#3a7a4a", "#8a7520", "#3a6a90", "#a85878", "#188580", "#2a2920"],
      out: dir + "/Cyclotron Light.terminal")
