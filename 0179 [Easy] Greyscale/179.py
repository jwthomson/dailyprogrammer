from PySide.QtCore import QCoreApplication
from PySide.QtGui import QImage

if __name__ == "__main__":
    app = QCoreApplication([])
    img = QImage("lenna.png")
    w, h = img.size().width(), img.size().width()
    for p in ((x, y) for x in range(w) for y in range(h)):
        colour = img.pixel(p[0], p[1])  # AARRGGBB
        r = colour & 0xFF
        g = (colour >> 8) & 0xFF
        b = (colour >> 16) & 0xFF
        avg = round((r + g + b) / 3)    # Naïve method (no colour weighting)
        new_colour = 0xff000000 + (avg << 16) + (avg << 8) + avg
        img.setPixel(p[0], p[1], new_colour)
    img.save("output.png")
