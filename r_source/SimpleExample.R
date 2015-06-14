

# AverageVector <- function(ip_adress, port, vec)
# {
# 	dyn.load("lib/RClient.so")
    
#     average = 0.0;

#     # char** ip, int* len_ip, char** port, int* len_port,
# 	out <- .C("SendVector", 
# 			  ip = ip_adress,
# 			  len_ip = nchar(ip_adress),
# 			  port = port,
# 			  len_port = nchar(port),
# 			  data = vec, 
# 			  size = as.integer(length(vec)),
# 			  average = as.double(average))

# 	return(out$average)
# }	

RServer.login <- function(ip_adress, port)
{
	return(c(ip_adress, port))
}

RServer.kmeans <- function(server_info, data, nCluster)
{
	dyn.load("lib/RClient.so")

	# print("R CudaKMean")

	matrix_dim = 0
	nrow = 0
	ncol = 0

	if(is.matrix(data) == TRUE) {
		matrix_size = dim(data)
		matrix_dim = length(matrix_size)
		nrow = matrix_size[1]
		ncol = matrix_size[2]

	} else {

		if(is.null(dim(data)))
		{
			print("IS VECTOR")
			matrix_dim = 1
			nrow = 1
			ncol = length(data)
		} else
		{
			print("PROBLEME")
			matrix_size = dim(data)
			matrix_dim = length(matrix_size)
			nrow = matrix_size[1]
			ncol = matrix_size[2]

			# data = matrix(data = data, nrow = nrow, ncol = ncol)
		}
	}

	# nnn = matrix(nrow = nCluster, ncol = ncol)
	# nnn = vector(length=nCluster * ncol, mode="numeric")
	nnn = vector(length=nCluster * ncol, mode="numeric")



	out <- .C("ServerKMean", 
			  ip = server_info[1],
			  len_ip = nchar(server_info[1]),
			  port = server_info[2],
			  len_port = nchar(server_info[2]),
			  data = data, 
			  nrow = as.integer(nrow), 
			  ncol = as.integer(ncol), 
			  nclust = as.integer(nCluster),
			  answer = nnn)


	# return(out$answer)
	return(matrix(data = out$answer, nrow = nCluster, ncol = ncol, byrow=FALSE))
}