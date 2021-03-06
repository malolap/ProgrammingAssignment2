## Matrix inversion is usually a costly computation and
## here writing a script to cache the inverse of a matrix 
## rather than computing it repeatedly.

## The first function, makeCacheMatrix function creates a special "matrix" object that can cache its inverse.
## Also, this really a list containing a function to
# 1. set the value of the matrix
# 2. get the value of the matrix
# 3. set the value of inverse of the matrix
# 4. get the value of inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) inv <<- inverse
  getinverse <- function() inv
  list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}

# The following function returns the inverse of the matrix. It first checks if
# the inverse has already been computed. If so, it gets the result and skips the
# computation. If not, it computes the inverse, sets the value in the cache via
# setinverse function.

# This function assumes that the matrix is always invertible.

cacheSolve <- function(x, ...) {
  inv <- x$getinverse()
  if(!is.null(inv)) {
    message("getting cached data.")
    return(inv)
  }
  data <- x$get()
# Computing the inverse of a square matrix can be done with the solve function in R. 
# For example, if X is a square invertible matrix, then solve(X) returns its inverse.
  inv <- solve(data)
  x$setinverse(inv)
        ## Return a matrix that is the inverse of 'x'
  inv
}

###Sample output######
# > x <- rbind(c(4, 3), c(3, 2))
# > m <- makeCacheMatrix(x)
# > m$get()
# [,1] [,2]
# [1,]    4    3
# [2,]    3    2
# > m$getinverse()
# NULL
# First run no cache data 
# > cacheSolve(m)
# [,1] [,2]
# [1,]   -2    3
# [2,]    3   -4
## Retrieving from the cache in the second run
# > cacheSolve(m)
# getting cached data.
# [,1] [,2]
# [1,]   -2    3
# [2,]    3   -4
# > m$getinverse()
# [,1] [,2]
# [1,]   -2    3
# [2,]    3   -4
# > 