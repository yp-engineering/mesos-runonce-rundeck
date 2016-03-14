all: clean zip

clean:
	rm -rf dist
	mkdir dist
zip:
	mkdir -p dist/mesos-runonce
	cp -r mesos-runonce/* dist/mesos-runonce
	(cd dist; zip -r ../dist/mesos-runonce.zip mesos-runonce)

