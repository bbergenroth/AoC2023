BEGIN {
	for (i = 1;i < 205;i++) {
		data[i]=1;
	}
	total = 0;
}

{	
	split($0, a, "|"); 
	split(a[1], b, ":"); 
	split(a[2], c, " "); 
	split(b[2], d, " "); 
	split(b[1], card, " ");
	x = card[2]
	cnt = 0; 
	for (i in c) 
		for (j in d) { 
			if (c[i] == d[j]) {
				cnt = cnt + 1;
			}
		}; 
	
	if (cnt == 0) 
		total = 0; 
	else total = total + (2^(cnt - 1)); 
	
	answer = answer + total; 
	
	for (n = x + 1;n <= cnt + x;n++) {
		data[n] = data[n] + data[x];
	}
}

END {
	total = 0
	for (i in data) {
		total = total + data[i];
	}
	print total;
}
	
