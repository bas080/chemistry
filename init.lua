--element format = {"El",<group>,<period>}
chemistry={}
chemistry.reaction=0
chemistry.reactions={}
chemistry.extraction=0
chemistry.extractions={}

local groups = {
  {"alkali metals",{
  
    {"H",1,1,1},
    {"Li",1,2,3},
    {"Na",1,3,11},
    {"K" ,1,4,19},
    {"Rb",1,5,37},
    {"Cs",1,6,55},
    {"Fr",1,7,87},
    
  }},
  {"alkaline earth metals",{
  
    {"Be",2,2,4},
    {"Mg",2,3,12},
    {"Ca",2,4,20},
    {"Sr",2,5,38},
    {"Ba",2,6,56},
    {"Ra",2,7,88},
    
  }},
  {"coinage metals",{
  
    {"Sc",3,4,21},
    {"Y" ,3,5,39},
    
    {"Ti",4,4,22},
    {"Zr",4,5,40},
    {"Hf",4,6,72},
    {"Rf",4,7,104},
    
    {"V" ,5,4,23},
    {"Nb",5,5,41},
    {"Ta",5,6,73},
    {"Db",5,7,105},
    
    {"Cr",6,4,24},
    {"Mo",6,5,42},
    {"W" ,6,6,74},
    {"Sg",6,7,106},
    
    {"Mn",7,4,25},
    {"Tc",7,5,43},
    {"Re",7,6,75},
    {"Bh",7,7,106},
    
    {"Fe",8,4,26},
    {"Ru",8,5,44},
    {"Os",8,6,76},
    {"Hs",8,7,107},
    
    {"Co",9,4,27},
    {"Rh",9,5,45},
    {"Ir",9,6,77},
    
    {"Ni",10,4,28},
    {"Pd",10,5,46},
    {"Pt",10,6,78},
    
    {"Cu",11,4,29},
    {"Ag",11,5,47},
    {"Au",11,6,79},
    
  }},
  {"volatile metals",{
  
    {"Zn",12,4,30},
    {"Cd",12,5,48},
    {"Hg",12,6,80},
    {"Cn",12,7,112},
    
  }},
  {"icosagens",{
  
    {"B"  ,13,2,5},
    {"Al" ,13,3,13},
    {"Ga" ,13,4,31},
    {"In" ,13,5,49},
    {"Tl" ,13,6,81},
    {"Uut",13,7,113},
    
  }},
  {"crystallogens",{
  
    {"C" ,14,2,6},
    {"Si",14,3,14},
    {"Ge",14,4,32},
    {"Sn",14,5,50},
    {"Pb",14,6,82},
    {"Fl",14,7,114},
    
  }},
  {"pnictogens",{
  
    {"N"  ,15,2,7},
    {"P"  ,15,3,15},
    {"As" ,15,4,33},
    {"Sb" ,15,5,51},
    {"Bi" ,15,6,83},
    {"Uup",15,7,115},
    
  }},
  {"chalcogens",{
  
    {"O" ,16,2,8},
    {"S" ,16,3,16},
    {"Se",16,4,34},
    {"Te",16,5,52},
    {"Po",16,6,84},
    {"Lv",16,7,116},
  
  }},
  {"halogens", {
    
    {"F"  ,17,2,9},
    {"CL" ,17,3,17},
    {"Br" ,17,4,35},
    {"I"  ,17,5,53},
    {"At" ,17,6,85},
    {"Uus",17,7,117},
  
  }},
  {"noble gases",{
  
    {"He" ,18,1,2},
    {"Ne" ,18,2,10},
    {"Ar" ,18,3,18},
    {"Kr" ,18,4,36},
    {"Xe" ,18,5,54},
    {"Rn" ,18,6,86},
    {"Uuo",18,7,118},

  }}
}
 
for i, group in ipairs(groups) do
  for ii, element in ipairs(group[2]) do
    --print(element[1].." "..element[4])
    minetest.register_node("chemistry:"..element[1], {
      description = element[1],
      tiles = {element[1]..".png"},
      inventory_image = element[1]..".png",
      groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,chemistry=1},
    })
  end
end

minetest.register_node("chemistry:extractor", {
  description = "Chemical extractor",
  tiles = {"chemistry_base.png", "chemistry_base.png", "extractor.png"},
  inventory_image = "extractor.png",
  groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,chemistry=1},
})

minetest.register_node("chemistry:reactor", {
  description = "Chemical reactor",
  tiles = {"chemistry_base.png", "chemistry_base.png", "reactor.png"},
  inventory_image = "reactor.png",
  groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,chemistry=1},
  on_construct = function(pos)
    local walk = 1
    walk_node = minetest.env:get_node({x=pos.x+walk, y=pos.y, z=pos.z})
    while minetest.get_item_group(walk_node.name, "chemistry") ~= 0 do
      print(walk)
      for i, reaction in ipairs(chemistry.reactions) do
        
      end
      walk = walk+1
      walk_node = minetest.env:get_node({x=pos.x+walk, y=pos.y, z=pos.z})
    end
  end,
})

minetest.register_node("chemistry:and", {
  description = "+",
  tiles = {"chemistry_base.png", "chemistry_base.png", "chemistry_and.png"},
  inventory_image = "chemistry_and.png",
  groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,chemistry=1},
})



function chemistry.register_reaction(reaction)
  chemistry.reaction=chemistry.reaction+1
  chemistry.reactions[chemistry.reaction]=reaction
end

function chemistry.register_extraction(extraction)
  chemistry.extractions[chemistry.extractions]=extraction
  print(extraction[1])
  chemistry.extraction=chemistry.extraction+1
end

chemistry:register_reaction({"default:water_source", 
  {{"H",2},{"H",2}},
  {{"O",2}},
})

chemistry:register_reaction({"default:water_source", 
  {{"H",2},{"H",2}},
  {{"O",3}},
})

function copytable(t)
    local copy = {}
    for key,val in pairs(t) do
        if type(val) == 'table' then
            copy[key] = copytable(val)
        else
            copy[key] = val
        end
    end
    return copy
end
