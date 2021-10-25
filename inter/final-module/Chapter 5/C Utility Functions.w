[CUtilities::] C Utility Functions.

Rounding out the C library with a few functions intended for external code to use.

@

= (text to inform7_clib.h)
char *i7_read_string(i7process_t *proc, i7word_t S);
void i7_write_string(i7process_t *proc, i7word_t S, char *A);
i7word_t *i7_read_list(i7process_t *proc, i7word_t S, int *N);
void i7_write_list(i7process_t *proc, i7word_t S, i7word_t *A, int L);
=

= (text to inform7_clib.c)
i7word_t fn_i7_mgl_TEXT_TY_Transmute(i7process_t *proc, i7word_t i7_mgl_local_txt);
i7word_t fn_i7_mgl_BlkValueRead(i7process_t *proc, i7word_t i7_mgl_local_from, i7word_t i7_mgl_local_pos, i7word_t i7_mgl_local_do_not_indirect, i7word_t i7_mgl_local_long_block, i7word_t i7_mgl_local_chunk_size_in_bytes, i7word_t i7_mgl_local_header_size_in_bytes, i7word_t i7_mgl_local_flags, i7word_t i7_mgl_local_entry_size_in_bytes, i7word_t i7_mgl_local_seek_byte_position);
i7word_t fn_i7_mgl_BlkValueWrite(i7process_t *proc, i7word_t i7_mgl_local_to, i7word_t i7_mgl_local_pos, i7word_t i7_mgl_local_val, i7word_t i7_mgl_local_do_not_indirect, i7word_t i7_mgl_local_long_block, i7word_t i7_mgl_local_chunk_size_in_bytes, i7word_t i7_mgl_local_header_size_in_bytes, i7word_t i7_mgl_local_flags, i7word_t i7_mgl_local_entry_size_in_bytes, i7word_t i7_mgl_local_seek_byte_position);
i7word_t fn_i7_mgl_TEXT_TY_CharacterLength(i7process_t *proc, i7word_t i7_mgl_local_txt, i7word_t i7_mgl_local_ch, i7word_t i7_mgl_local_i, i7word_t i7_mgl_local_dsize, i7word_t i7_mgl_local_p, i7word_t i7_mgl_local_cp, i7word_t i7_mgl_local_r);

char *i7_read_string(i7process_t *proc, i7word_t S) {
	fn_i7_mgl_TEXT_TY_Transmute(proc, S);
	int L = fn_i7_mgl_TEXT_TY_CharacterLength(proc, S, 0, 0, 0, 0, 0, 0);
	char *A = malloc(L + 1);
	if (A == NULL) {
		fprintf(stderr, "Out of memory\n"); i7_fatal_exit(proc);
	}
	for (int i=0; i<L; i++) A[i] = fn_i7_mgl_BlkValueRead(proc, S, i, 0, 0, 0, 0, 0, 0, 0);
	A[L] = 0;
	return A;
}

void i7_write_string(i7process_t *proc, i7word_t S, char *A) {
	fn_i7_mgl_TEXT_TY_Transmute(proc, S);
	fn_i7_mgl_BlkValueWrite(proc, S, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	if (A) {
		int L = strlen(A);
		for (int i=0; i<L; i++) fn_i7_mgl_BlkValueWrite(proc, S, i, A[i], 0, 0, 0, 0, 0, 0, 0);
	}
}

i7word_t fn_i7_mgl_LIST_OF_TY_GetLength(i7process_t *proc, i7word_t i7_mgl_local_list);
i7word_t fn_i7_mgl_LIST_OF_TY_SetLength(i7process_t *proc, i7word_t i7_mgl_local_list, i7word_t i7_mgl_local_newsize, i7word_t i7_mgl_local_this_way_only, i7word_t i7_mgl_local_truncation_end, i7word_t i7_mgl_local_no_items, i7word_t i7_mgl_local_ex, i7word_t i7_mgl_local_i, i7word_t i7_mgl_local_dv);
i7word_t fn_i7_mgl_LIST_OF_TY_GetItem(i7process_t *proc, i7word_t i7_mgl_local_list, i7word_t i7_mgl_local_i, i7word_t i7_mgl_local_forgive, i7word_t i7_mgl_local_no_items);
i7word_t fn_i7_mgl_LIST_OF_TY_PutItem(i7process_t *proc, i7word_t i7_mgl_local_list, i7word_t i7_mgl_local_i, i7word_t i7_mgl_local_v, i7word_t i7_mgl_local_no_items, i7word_t i7_mgl_local_nv);

i7word_t *i7_read_list(i7process_t *proc, i7word_t S, int *N) {
	int L = fn_i7_mgl_LIST_OF_TY_GetLength(proc, S);
	i7word_t *A = calloc(L + 1, sizeof(i7word_t));
	if (A == NULL) {
		fprintf(stderr, "Out of memory\n"); i7_fatal_exit(proc);
	}
	for (int i=0; i<L; i++) A[i] = fn_i7_mgl_LIST_OF_TY_GetItem(proc, S, i+1, 0, 0);
	A[L] = 0;
	if (N) *N = L;
	return A;
}

void i7_write_list(i7process_t *proc, i7word_t S, i7word_t *A, int L) {
	fn_i7_mgl_LIST_OF_TY_SetLength(proc, S, L, 0, 0, 0, 0, 0, 0);
	if (A) {
		for (int i=0; i<L; i++) 
			fn_i7_mgl_LIST_OF_TY_PutItem(proc, S, i+1, A[i], 0, 0);
	}
}
=

@

= (text to inform7_clib.h)
#endif
=

= (text to inform7_clib.c)
#endif
=