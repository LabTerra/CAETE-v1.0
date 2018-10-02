
In [26]: for f in dirs:
    ...:     os.chdir(f)
    ...:     files = glob.glob1(os.getcwd(), "*.nc")
    ...:     outs = [f10.split(".")[0] + ".tar.gz" for f10 in files]
    ...:     for f1,f2 in zip(files,outs):
    ...:         os.system("tar -cvzf %s %s" % (f2, f1))
    ...:         os.system("rm -rf %s" % f1)
    ...:     os.chdir(root)
