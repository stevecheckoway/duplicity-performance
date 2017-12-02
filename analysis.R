require(chron)

# Load the CSV files.
paramiko <- read.csv("paramiko.csv", stringsAsFactors=F)
pexpect <- read.csv("pexpect.csv", stringsAsFactors=F)

# Open the output file.

png("performance.png")

# Compute the coordinates for paramiko.
times <- chron(paramiko$Date, paramiko$Time, format=c("y-m-d", "h:m:s"))
delta.times <- difftime(times, times[1], units='hours')
total.bytes <- cumsum(as.numeric(paramiko$Bytes)) - paramiko$Bytes[1]

plot(total.bytes/2^30, delta.times, type='l', col='red',
     xlim=c(0, 20), ylim=c(0, 50),
     xlab='Gigabytes transferred', ylab='Hours')
title("Performance of Duplicity SSH Backends")

# Compute the coordinates for pexpect.
times <- chron(pexpect$Date, pexpect$Time, format=c("y-m-d", "h:m:s"))
delta.times <- difftime(times, times[1], units='hours')
total.bytes <- cumsum(as.numeric(pexpect$Bytes)) - pexpect$Bytes[1]

lines(total.bytes/2^30, delta.times, col='blue')

legend('topleft', legend=c("Paramiko", "Pexpect"), col=c("red","blue"), lty=1)
dev.off()
