source("r_source/SimpleExample.R")

ncol = 1000
nrow = 1000
nCluster = 500;

v = c();
for(i in 1:nrow)
{
	v = c(v, runif(ncol, 5.0, 7.5))
}

# Row vector matrix.
data = matrix(data = v, nrow = nrow, ncol = ncol, byrow=TRUE)

# RServer connection info.
server_info = RServer.login("192.168.0.102", "9000");

ptm <- proc.time()
answer = RServer.kmeans(server_info, data, nCluster)
tt = proc.time() - ptm

# print(answer)
print(tt)


ptm <- proc.time()
answer = kmeans(data, nCluster, iter.max = 100)
tt = proc.time() - ptm

# print(answer$centers)
print(tt)
