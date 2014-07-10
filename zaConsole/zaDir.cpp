/*
 * zaDir.cpp
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */

#include "zaDir.h"

zaDir::zaDir() {
	// TODO Auto-generated constructor stub

}
int zaDir::dirlist() {
	return dirlist("/accounts/1000/appdata");
}

int zaDir::dirlist(const char * p) {
	struct dirent *ptr;
	DIR *dir;
	dir = opendir(p);
	if (dir == NULL)
		return -1;
	m_y = -300;
	strcpy(m_path, p);
	int i = 0;
	strcpy(m_output[i], m_path);
	if (m_path[strlen(m_path) - 1] == '/')
		strcat(m_output[i], "..");
	else
		strcat(m_output[i], "/..");
	i++;
	m_index = 0;
	fprintf(stderr, "pwd \n", m_path);
	while ((ptr = readdir(dir)) != NULL) {

		//跳过'.'和'..'两个目录
		if (ptr->d_name[0] == '.')
			continue;
		if (strcmp(m_path, "/") != 0)
			strcpy(m_output[i], m_path);
		else
			strcpy(m_output[i], "");
		strcat(m_output[i], "/");
		strcat(m_output[i], ptr->d_name);
		filedesc(m_output[i], i);
		i++;
		fprintf(stderr, "<%s>\n", ptr->d_name);
	}
	m_output[i][0] = 0;
	closedir(dir);
	fprintf(stderr, "%s", "ov1");
	m_index_log = 0;
	return 0;
}

int zaDir::filedesc(const char * filename, int index) {
	stat(filename, &m_sb[index]);
//	 switch (sb.st_mode & S_IFMT)
//	 {
//	           case S_IFBLK:  printf("block device\n");            break;
//	           case S_IFCHR:  printf("character device\n");        break;
//	           case S_IFDIR:  printf("directory\n");               break;
//	           case S_IFIFO:  printf("FIFO/pipe\n");               break;
//	           case S_IFLNK:  printf("symlink\n");                 break;
//	           case S_IFREG:  printf("regular file\n");            break;
//	           case S_IFSOCK: printf("socket\n");                  break;
//	           default:       printf("unknown?\n");                break;
//	 }
//
//	  printf("I-node number:            %ld\n", (long) sb.st_ino);
//
//	  printf("Mode:                     %lo (octal)\n",
//	                                 (unsigned long) sb.st_mode);
//
//	           printf("Link count:               %ld\n", (long) sb.st_nlink);
//	           printf("Ownership:                UID=%ld   GID=%ld\n",
//	                   (long) sb.st_uid, (long) sb.st_gid);
//
//	           printf("Preferred I/O block size: %ld bytes\n",
//	                   (long) sb.st_blksize);
//	           printf("File size:                %lld bytes\n",
//	                   (long long) sb.st_size);
//	           printf("Blocks allocated:         %lld\n",
//	                   (long long) sb.st_blocks);
//
//	           printf("Last status change:       %s", ctime(&sb.st_ctime));
//	           printf("Last file access:         %s", ctime(&sb.st_atime));
//	           printf("Last file modification:   %s", ctime(&sb.st_mtime));

	return 0;
}

void zaDir::porcess(zaWorker * wk) {
	m_dirty = true;
	if (wk->m_task == 2) {
		if (wk->m_len < 20) {
			soundplayer_play_sound("input_keypress");
			if (m_index_log != 0) {
				m_index_log = 0;
				return;
			}

			if (m_index != 0) {
				dirlist(m_output[m_index]);
			} else {
				strcpy(m_path, m_output[m_index]);
				int n = 0;
				for (int i = strlen(m_path) - 1; i >= 0; i--) {
					if (m_path[i] == '/') {
						n++;
						if (i == 0)
							m_path[1] = 0;
						else
							m_path[i] = 0;
					}
					if (n == 2) {
						break;
					}
				}
				fprintf(stderr, "pwd 2 %s \n", m_path);
				dirlist(m_path);
			}
		}
	} else
		m_y -= wk->m_dy;
}

int zaDir::render() {
//	if (!m_dirty)
//		return 0;

	m_dirty = false;

	if (!font) {
		fprintf(stderr, "font err");
		return EXIT_FAILURE;
	}
	int l_y = 0;

	if (m_index_log > 0) {
		glColor4f(0.8f, 0.8f, 0.8f, 1.0f);
		for (int i = 0; i < m_index_log; i++) {
			l_y = m_y + 580 - i * 30;
			bbutil_render_text(font, m_log[i], 20.0f, l_y);
		}
		return 0;
	}

	glColor4f(0.0f, 0.0f, 0.8f, 1.0f);
	bbutil_render_text(font, "Touch Console", 850.0f, 580.0f);
	int i = 0;
	l_y = 0;
	while (m_output[i][0] != 0) {
		l_y = m_y + 600 - i * 30;

		if (l_y <= 270) {
			l_y -= 30;
			disinfo(10, l_y, i);
			glColor4f(0.0f, 0.6f, 0.0f, 1.0f);
		} else if (l_y > 270 && l_y <= 300) {
			m_index = i;
			if ((m_sb[i].st_mode & S_IFMT) == S_IFREG)
				m_file = true;
			else
				m_file = false;
			float r = 3.14f / 2 * (1 - float(l_y - 285) / 15);
			l_y += 30.0f * cos(r);
			disinfo(10, l_y, i);
			glColor4f(0.4f + 0.6f * sin(r), 0.4f + 0.6f * sin(r), 0.0f, 1.0f);
		} else // l_y >300
		{
			l_y += 30;
			disinfo(10, l_y, i);
			glColor4f(0.0f, 0.6f, 0.0f, 1.0f);
		}
		bbutil_render_text(font, m_output[i], 270.0f, l_y);
		i++;
	}
	return 0;
}

void zaDir::disinfo(int l_x, int l_y, int i) {

	char info[30];
	switch (m_sb[i].st_mode & S_IFMT) {
	case S_IFBLK:
		sprintf(info, "B");
		glColor4f(0.0f, 0.0f, 0.8f, 1.0f);
		break;
	case S_IFCHR:
		sprintf(info, "C");
		glColor4f(0.0f, 0.0f, 0.8f, 1.0f);
		break;
	case S_IFDIR:
		sprintf(info, "D");
		glColor4f(0.0f, 0.6f, 0.6f, 1.0f);
		break;
	case S_IFIFO:
		sprintf(info, "P");
		glColor4f(1.0f, 0.0f, 0.8f, 1.0f);
		break;
	case S_IFLNK:
		sprintf(info, "L");
		glColor4f(1.f, 0.0f, 0.8f, 1.0f);
		break;
	case S_IFREG:
		sprintf(info, "F");
		glColor4f(0.0f, 0.6f, 0.0f, 1.0f);
		break;
	case S_IFSOCK:
		sprintf(info, "S");
		break;
	default:
		sprintf(info, "U");
		glColor4f(1.0f, 0.0f, 0.8f, 1.0f);
		break;
	}

	bbutil_render_text(font, info, 10.0f, l_y);

	glColor4f(0.0f, 0.6f, 0.0f, 1.0f);

	sprintf(info, "%ld-%ld ", (long) m_sb[i].st_uid, (long) m_sb[i].st_gid);

	bbutil_render_text(font, info, 40.0f, l_y);

	if ((unsigned long) m_sb[i].st_mode & 0x4)
		glColor4f(0.1f, 0.8f, 0.9f, 1.0f);
	else
		glColor4f(0.6f, 0.8f, 0.4f, 1.0f);
	sprintf(info, "%8lo", (unsigned long) m_sb[i].st_mode & 0x3FF);

	bbutil_render_text(font, info, 130.0f, l_y);

	if (m_sb[i].st_size > 1024 * 1024) {
		glColor4f(0.3f, 0.3f, 0.6f, 1.0f);
		sprintf(info, "%8lldM", (long long) m_sb[i].st_size / 1024 / 1024);
	} else if (m_sb[i].st_size > 9999) {
		glColor4f(0.3f, 0.3f, 0.4f, 1.0f);
		sprintf(info, "%8lldK", (long long) m_sb[i].st_size / 1024);
	} else {
		glColor4f(0.3f, 0.3f, 0.3f, 1.0f);
		sprintf(info, "%8lld", (long long) m_sb[i].st_size);
	}

	bbutil_render_text(font, info, 180.0f, l_y);

	sprintf(info, "%s", ctime(&m_sb[i].st_ctime));

	//bbutil_render_text(font,info, -200.0f, l_y);
}

void zaDir::exec() {
	soundplayer_play_sound("notification_general");
	FILE *read_fp = NULL;
	char buffer[BUFSIZ + 1];
	char out[BUFSIZ + 1];
	int chars_read = 0;
	int i = 0;

	char cmd[255];

	sprintf(cmd, "%s", this->m_output[m_index]);

	memset(buffer, 0, sizeof(buffer));
	memset(out, 0, sizeof(out));

	read_fp = popen(cmd, "r");

	if (read_fp != NULL) {
		while ((chars_read = fread(buffer, sizeof(char), 50, read_fp)) > 0) {
			char t;
			int pos = 0;
			for (size_t m = 0; m < strlen(buffer); m++) {
				t = buffer[m];
				if (t == 0x0A) {

					strcpy(m_log[i], out);
					//bbutil_render_text(font, out , 10.0f, 600-i*30.0f);
					i++;
					if (i > 450)
						break;
					pos = 0;
				} else if (t != 0x0D) {
					out[pos] = t;
					pos++;
					out[pos] = 0;
				}
			}
			if (pos > 0)
				strcpy(m_log[i], out);
			m_index_log = i;

			fprintf(stderr, "Output:%d %s /n", i, buffer);
		}
	}
	pclose(read_fp);
}

void zaDir::ppopen() {
	soundplayer_play_sound("event_camera_shutter");
	FILE *read_fp = NULL;
	char buffer[BUFSIZ + 1];
	char out[BUFSIZ + 1];
	int chars_read = 0;
	int i = 0;

	char cmd[255];

	sprintf(cmd, "cat %s ", this->m_output[m_index]);

	memset(buffer, 0, sizeof(buffer));
	memset(out, 0, sizeof(out));

	read_fp = popen(cmd, "r");
	int pos = 0;
	if (read_fp != NULL) {
		while ((chars_read = fread(buffer, sizeof(char), 50, read_fp)) > 0) {
			char t;
			if(i == -1) i++;
			for (size_t m = 0; m < strlen(buffer); m++) {
				t = buffer[m];
				if (t == 0x0A) {
					strcpy(m_log[i], out);
					fprintf(stderr, "%d->%s \n", i, out);
					//bbutil_render_text(font, out , 10.0f, 600-i*30.0f);
					i++;
					if (i > 450)
						break;
					pos = 0;
				} else if (t != 0x0D) {
					out[pos] = t;
					pos++;
					out[pos] = 0;
				}
			}
		}
		if (pos > 0)
		{
			if ( i == 0) i ++;
			strcpy(m_log[i], out);
		}
		m_index_log = i;
	}
	pclose(read_fp);
}

zaDir::~zaDir() {
	// TODO Auto-generated destructor stub
}

