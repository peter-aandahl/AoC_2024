

for m in eachmatch(r"XMAS", reverse("MMMSXXMASMXMASXXXMASXSAMXX")) 
    println("Matched $(m.match) at index $(m.offset)") 
end

