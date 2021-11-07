module.exports = {
  mode: 'jit',
  purge: ['./src/**/*.bs.js'],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        main: '#3789A4',
        accent: '#1F4D5C',
        dark: '#0D1F26',
        light: '#D9EEF2'
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
