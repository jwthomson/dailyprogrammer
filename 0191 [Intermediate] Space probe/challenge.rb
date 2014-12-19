dimension = 20
cell_count = dimension * dimension
asteroids = (0.3 * cell_count).floor  # 30% asteroids
gravity = (0.1 * cell_count).floor    # 10% gravity wells

# with for example 5x5 cells we make 7 asteroids and 2 gravity wells
# represented as: "aaaaaaagg................"
# chars.shuffle:  [ 
#                    ".", ".", ".", "a", "g",
#                    ".", ".", ".", "a", ".",
#                    "a", "a", ".", ".", "a",
#                    ".", ".", "g", ".", ".",
#                    ".", ".", ".", "a", "a"
#                 ]
#
# slice by 5:     [
#                   [".", ".", ".", "a", "g"],
#                   [".", ".", ".", "a", "."],
#                   ["a", "a", ".", ".", "a"],
#                   [".", ".", "g", ".", "."],
#                   [".", ".", ".", "a", "a"]
#                 ]

tmp = ((("A" * asteroids) + ("G" * gravity)).ljust(cell_count, '.').chars.shuffle.each_slice(dimension).to_a)

# unfinished!
# todo:
#   add gravity well functionality
#   add pathfinding

#display in a box
puts "_" * (dimension + 2), tmp.map{ |s| "|" + s.join + "|" }, "-" * (dimension + 2)