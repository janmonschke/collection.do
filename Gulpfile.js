var gulp = require('gulp');
var notify = require('gulp-notify');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var stylus = require('gulp-stylus');
var nib = require('nib');
var mocha = require('gulp-mocha');

var env = process.env.NODE_ENV || 'development';
var isDebugEnv = env == 'development';
var isProductionEnv = env == 'production';

gulp.task('browserify', function(){
    return browserify('./app/app.js')
        .bundle()
        .on('error', function(err){
          if(isDebugEnv){
            var args = Array.prototype.slice.call(arguments);

            notify.onError({
              title: "Compile Error",
              message: "<%= error.message %>"
            }).apply(this, args);
          }
          console.error(err.message);
          this.emit('end');
        })
        .pipe(source('app.js'))
        .pipe(gulp.dest('./public/'));
});

gulp.task('stylus', function(){
  var stylusOptions = {
    use: [nib()],
    compress: isProductionEnv
  };
  return gulp.src('styles/app.styl')
        .pipe(stylus(stylusOptions))
        .pipe(gulp.dest('public/'))
});

gulp.task('test', function(){
  require('should');
  return gulp.src('test/**/*.js', {read: false})
        .pipe(mocha({reporter: 'dot'}));
});

gulp.task('watch', function(){
  gulp.watch('app/**/*.js', ['browserify', 'test']);
  gulp.watch('test/**/*.js', ['test']);
  // gulp.watch('server/**/*.coffee', ['test']);
  gulp.watch('styles/**/*.styl', ['stylus']);
});

gulp.task('default', ['browserify', 'stylus', 'test', 'watch']);