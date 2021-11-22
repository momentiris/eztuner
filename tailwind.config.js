module.exports = {
  purge: ['./src/**/*.bs.js'],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      fontFamily: {
        main: ['Roboto Mono', 'monospace'],
      },
      colors: {
        main: '#3789A4',
        accent: '#1F4D5C',
        accentlight: '#b6c8cc',
        dark: '#0D1F26',
        light: '#D9EEF2',
      },
      width: {
        note: 'calc((100% / 3) - 1rem)',
        halfNote: 'calc((100% / 3) + 0.5rem)',
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
