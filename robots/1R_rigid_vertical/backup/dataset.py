import pickle as pk

file = open('dataset.txt','r')
out = open('rigid_vertical', 'wb')

lines = file.readlines()
file.close()


for line in lines:
    data = line.strip().split(" ")
    q = float(data[0])
    qd = float(data[1])
    qdd = float(data[2])
    pk.dump([q,qd,qdd], out)

out.close()