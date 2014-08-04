hex_strings = [
  "FF 81 BD A5 A5 BD 81 FF",
  "AA 55 AA 55 AA 55 AA 55",
  "3E 7F FC F8 F8 FC 7F 3E",
  "93 93 93 F3 F3 93 93 93",
]

def hex_data_to_image(hex_data):
  for hex_pair in hex_data:
    for divisor in reversed(range(len(hex_data))):
      print("X" if (int(hex_pair, 16) >> divisor & 1) == 1 else " ", end="")
    print()

if __name__ == "__main__":
  for x in range(len(hex_strings)):
    hex_data = hex_strings[x].split(' ')
    hex_data_to_image(hex_data)
