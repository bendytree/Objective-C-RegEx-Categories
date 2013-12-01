

"dog frog".replace(/[a-z]+/, function(){ console.log(arguments); return "mog"; });
 => ["dog", 0, "dog frog"] 
 => "mog frog"


"ab cd ef".match(/[a-z]([a-z])/)
 => ["ab", "b"]
 
 
"ab cd ef".match(/[a-z]([a-z])/g)
 => ["ab", "cd", "ef"]
 

