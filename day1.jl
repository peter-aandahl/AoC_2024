using CSV, DataFrames
df = DataFrame(CSV.File("data/day1.txt", header = false))

c1 = sort(df.Column1; alg = QuickSort)
c2 = sort(df.Column2; alg = QuickSort)

global sum = similar = 0

for i in 1:length(c1)
    global sum=sum+abs(c1[i]-c2[i])
    global similar=similar+c1[i]*count(x->(x==c1[i]), c2)
end

println(sum, " ", similar)